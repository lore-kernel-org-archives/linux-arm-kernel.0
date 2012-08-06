From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Aug 2012 13:36:23 +0100
Subject: [PATCH 6/6] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <1344250002-6011-7-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
 <1344250002-6011-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20120806123622.GA10524@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 11:46:42AM +0100, Lee Jones wrote:
> If we're booting with Device Tree enabled, we want the IRQ numbers to
> be taken and translated from the Device Tree binary. If not, they
> should be taken from the resource allocation defined in the AB8500 MFD
> core driver.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/input/misc/ab8500-ponkey.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Revoked, sent elsewhere.
