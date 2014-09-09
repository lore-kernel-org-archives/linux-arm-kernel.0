From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 02:51:42 -0400
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <4569324.eR9S3K10NB@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <20140902162606.GX29327@sirena.org.uk> <2913007.3xRNb2X4ts@vostro.rjw.lan>
 <4569324.eR9S3K10NB@wuerfel>
Message-ID: <540EA37E.6040005@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 09/03/2014 11:09 AM, Arnd Bergmann wrote:
> On Wednesday 03 September 2014 01:00:23 Rafael J. Wysocki wrote:

>> Our intention is specifically not to use "random incompatible bindings"
>> in that.  We'd rather have a common venue and process for establishing
>> new bindings for both DT and _DSD in a compatible way.
> 
> Right, I think everyone is on the same page for the embedded x86 case,
> my point was that there is no consensus about that yet among the
> parties involved in arm64 servers.

However, in the case of MAC devices where you might need to specify just
a couple of properties using _DSD, a specific set of discussions has
been instigated. As you mentioned, though, this pertains only to certain
devices and isn't necessarily true for every Ethernet device.
Consequently, while a Juno PoC patch might use a kludge today, that
doesn't mean it's a limitation of ACPI, just of certain devices.

Jon.
