From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 19:05:33 +0200
Subject: [PATCH v2 4/7] clk: exynos5420: Rename clock names
In-Reply-To: <1395918470-16374-5-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
 <1395918470-16374-5-git-send-email-shaik.ameer@samsung.com>
Message-ID: <534D66DD.30503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On 27.03.2014 12:07, Shaik Ameer Basha wrote:
> From: Rahul Sharma <rahul.sharma@samsung.com>
>
> Maintain the mout_, dout_, sclk_ prefix to the clock names
> wherever applicable.

Looking at the patch, it does seem to do more than that. Considering my 
comments to patch 3/7, I would drop the renames simply adding *CLK_ 
prefix (except SCLK_, which is fine as it specifies clock type, just as 
MOUT_/DOUT_/etc.).

Best regards,
Tomasz
