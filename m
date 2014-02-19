From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 19 Feb 2014 12:54:34 +0100
Subject: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <20140218233645.GP31892@mtj.dyndns.org>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
Message-ID: <53049B7A.6080404@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/19/2014 12:36 AM, Tejun Heo wrote:
> On Mon, Feb 17, 2014 at 12:56:58PM +0000, Lee Jones wrote:
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: linux-ide at vger.kernel.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Please consider basing it on top of Hans' refactored ahci_platform.
> 
>  http://www.spinics.net/lists/linux-ide/msg47628.html

Which reminds I must test the version I've rebased on top of 3.14-rc1
and then send a v6 so that this can get merged.

Lee, I'll add you to the CC of the v6 I'm about to send.

Regards,

Hans
