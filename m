From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 29 Oct 2012 14:15:55 +0800
Subject: [PATCH 5/5] ASoC: sam9g20_wm8731: fix the issue for non-DT kernel
In-Reply-To: <20121027221420.GN4564@opensource.wolfsonmicro.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-5-git-send-email-voice.shen@atmel.com>
 <20121027221420.GN4564@opensource.wolfsonmicro.com>
Message-ID: <508E1F1B.8040308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 6:14, Mark Brown wrote:
> On Mon, Oct 22, 2012 at 06:17:59PM +0800, Bo Shen wrote:
>> When register platform from DAIs, the platform device to PCM no longer
>> needed. So, fix it with this patch
>
> This should be squashed into the change which changes the registeration
> to ensure that we don't get both methods used simultaneously.

OK, I will fix this in next version.

BRs,
Bo Shen
