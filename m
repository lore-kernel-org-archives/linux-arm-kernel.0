From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 20 Aug 2013 03:42:52 +0200
Subject: [PATCH] mfd: dbx500-prcmu: Move PRCMU numerical clock
 identifiers into DT include file
In-Reply-To: <1376912287-26460-1-git-send-email-lee.jones@linaro.org>
References: <1376912287-26460-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130820014251.GG13324@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Aug 19, 2013 at 12:38:07PM +0100, Lee Jones wrote:
> These are required to request DBx500 PRCMU clocks from Device Tree. The
> numbers used are taken directly from the Hardware Specification document.
> We're moving them from the DBx500 PRCMU include file into the DT include
> directory and referencing them from the former via a #include.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Since I expect you want to carry that through your tree:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
