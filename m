From: david@lechnology.com (David Lechner)
Date: Fri, 15 Apr 2016 11:21:04 -0500
Subject: [PATCH 0/2] da8xx clocks (was part of "da8xx USB clocks")
In-Reply-To: <57108BFA.4080509@ti.com>
References: <1460661217-7389-1-git-send-email-david@lechnology.com>
 <570FEEDB.7000109@lechnology.com> <57108BFA.4080509@ti.com>
Message-ID: <571114F0.7020504@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 01:36 AM, Sekhar Nori wrote:

>
> No, I had commented about removing the new clk init function you had
> introduced so I was waiting for that to be addressed. I was okay with
> the second patch in this series, but did not push it to master branch as
> it depends on clk init movement and breaks boot if applied independently.
>

Got it. The second patch disappeared when I rebased, so it threw me off.
