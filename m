From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 18 May 2016 16:04:32 -0700
Subject: [PATCH INTERNAL v2 1/3] Documentation: dt: Add Broadcom iproc pwm
 controller binding
In-Reply-To: <20160518221546.GA32596@rob-hp-laptop>
References: <1463554441-47982-1-git-send-email-yendapally.reddy@broadcom.com>
 <1463554441-47982-2-git-send-email-yendapally.reddy@broadcom.com>
 <20160518221546.GA32596@rob-hp-laptop>
Message-ID: <573CF500.5070708@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 16-05-18 03:15 PM, Rob Herring wrote:
> Am I supposed to ignore since this is "internal"?
The "INTERNAL" was supposed to be removed after internal review before 
sending out to the public mailing list.

Also, Yendapally's git email config was not setup properly so some are 
tagging the patchset as spam.

Other than that, everything is fine with the PATCH sent out to the open 
source community :)

I'm sure Yendapally will send out an updated version with those items 
corrected (and can add your Acked-by now).

Thanks,
  Scott

>
> On Wed, May 18, 2016 at 02:53:59AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
>> Add a binding for Broadcom iproc pwm controller
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> ---
>>   .../devicetree/bindings/pwm/brcm,iproc-pwm.txt      | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
>
> Acked-by: Rob Herring <robh@kernel.org>
>
