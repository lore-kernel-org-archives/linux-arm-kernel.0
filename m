From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Feb 2014 09:03:48 +0100
Subject: [PATCH v7 13/15] ARM: sun4i: dt: Remove grouping + simple-bus
 compatible for regulators
In-Reply-To: <20140222214421.GC3610@lukather>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-14-git-send-email-hdegoede@redhat.com>
 <20140222214421.GC3610@lukather>
Message-ID: <5309AB64.7010603@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 02/22/2014 10:44 PM, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Feb 22, 2014 at 04:53:42PM +0100, Hans de Goede wrote:
>> According to Documentation/devicetree/bindings/regulator/regulator.txt regulator nodes should not be placed under 'simple-bus'.
>> 
>> Mark Rutland also explains about it at: http://www.spinics.net/lists/linux-usb/msg101497.html
>> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Applied in my sunxi/dt-for-3.15 branch.

Thanks, I assume this only applies to this patch, since we were still
discussing the common regulator bits of the ahci enablement dts patches ?

I'm not seeing any of your recent merges here:
https://github.com/mripard/linux/commits/sunxi/dt-for-3.15

Did you not push them, or am I looking at the wrong tree ?

Regards,

Hans

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMJq18ACgkQF3VEtJrzE/vngACfbYd5K2ZixBm45Y+e3cMFSq9M
v68Anjze6R6meI1Z5R0l4nFCNS8txl9p
=0XGo
-----END PGP SIGNATURE-----
