From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 18:38:51 +0300
Subject: [PATCH v3 9/9] omap: zoom: add mmc3/wl1271 device support
In-Reply-To: <4C626140.3080107@nokia.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
	<1281478348-24833-10-git-send-email-ohad@wizery.com>
	<4C626140.3080107@nokia.com>
Message-ID: <AANLkTik8yftwy9Toq473134vcdoFN1Z29oTc9MGEUzue@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 11:37 AM, Roger Quadros <roger.quadros@nokia.com> wrote:
>> + ? ? ? ? ? ? ? .ocr_mask ? ? ? = MMC_VDD_165_195,
>
> Do we really need to specify ocr_mask here?

Removed, thanks!
