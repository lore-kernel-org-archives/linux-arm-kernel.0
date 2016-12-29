From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 29 Dec 2016 13:43:46 +0200
Subject: [PATCH 7/8] ARM: s3c64xx: Drop initialization of unused struct
 s3c_audio_pdata fields
In-Reply-To: <0bb15f0e-7033-4cb3-5aba-0bb61fdfc467@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <1478791076-19528-8-git-send-email-s.nawrocki@samsung.com>
 <20161228175344.3krz2hqrem56ypg6@kozik-lap>
 <CGME20161229103055epcas1p1dc69aec56d462e8c1605fe9e47ded562@epcas1p1.samsung.com>
 <0bb15f0e-7033-4cb3-5aba-0bb61fdfc467@samsung.com>
Message-ID: <20161229114346.hmq4bzzc3w2ylr3d@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 11:30:49AM +0100, Sylwester Nawrocki wrote:
> On 12/28/2016 06:53 PM, Krzysztof Kozlowski wrote:
> > On Thu, Nov 10, 2016 at 04:17:55PM +0100, Sylwester Nawrocki wrote:
> >> Remove initialization of dma_{filter, playback, capture, capture_mic}
> >> fields where it is not used any more.
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> ---
> >>  arch/arm/mach-s3c64xx/dev-audio.c | 19 -------------------
> >>  1 file changed, 19 deletions(-)
> >>
> > Sylwester,
> > 
> > This and 8/8 should be safe to apply, right?
> 
> Yes, I think both patches can be applied safely now.
> Thanks for getting back to this.

Thanks, applied both.

Best regards,
Krzysztof
