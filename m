From: vitalywool@gmail.com (Vitaly Wool)
Date: Wed, 19 Jan 2011 11:50:28 +0100
Subject: [PATCH] drivers: mmc: msm: remove clock disable in probe
In-Reply-To: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>
References: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <AANLkTim-=40MM=TeH1XSQ-rio1ctwcZAs4qbf9SaxmdH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 18, 2011 at 7:14 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> The probe function adds the MMC host which can start accepting request
> immediately. There is an assumption here that no requests happen
> immediatly, but it's not always the case. This assumption can causes
> a BUG() when the clocks are disabled. The fix is to just remove the
> clock disable in the probe function.
>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

I can add acked-by and/or tested-by if needed.

~Vitaly
