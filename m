From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 7 Nov 2014 11:17:14 +0100
Subject: [PATCH 1/4] input: touchscreen: ti_am335x_tsc Interchange
 touchscreen and ADC steps
In-Reply-To: <545C59CD.3070707@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <1414408111-2631-2-git-send-email-vigneshr@ti.com>
 <20141106141916.GA17151@netboy> <545C59CD.3070707@ti.com>
Message-ID: <20141107101714.GA23102@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 11:04:05AM +0530, Vignesh R wrote:
> Currently, there is too much noise in the TSC hardware that is being
> removed by delta filtering. I tested TSC unit by removing filtering
> logic, the performance was not at all satisfactory. The cursor jumps
> wayward and smooth circles cannot be drawn. Looks like delta filtering
> cannot be removed as of now. May be I will try and address it in future.

FWIW, on the boards that I tested, I printed the measured values out,
and I found that with 5 repetitions, I got the same value 5 times,
plus or minus a very small delta.

Thanks,
Richard
