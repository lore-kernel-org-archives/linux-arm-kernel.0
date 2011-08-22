From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 22 Aug 2011 15:55:30 +0200
Subject: [PATCH v2 0/4] Fixes to twl4030-madc and add BeagleBoard support
In-Reply-To: <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
	<1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Message-ID: <20110822135530.GR4607@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyle,

On Thu, Aug 11, 2011 at 10:33:11PM -0500, Kyle Manna wrote:
> These patches add basic functionality to the twl4030-madc driver to make
> it work on the BeagleBoard xM.
> 
> Version 2 adds fixes per Grazvydas Ignotas and the check for NULL pointer patch.
> 
> Kyle Manna (4):
>   mfd: twl4030-madc: copy the device pointer
>   mfd: twl4030-madc: turn on the MADC clock
>   mfd: twl4030-madc: check for NULL pointer
>   arm: BeagleBoard: add support for the twl4030-madc
Tony, are you ok with the BeagleBoard changes ?
The MFD ones look fine to me, I'd like to apply them.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
