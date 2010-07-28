From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 28 Jul 2010 21:12:50 +0200 (CEST)
Subject: JPEG hw decoder
In-Reply-To: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
References: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1007282110130.23907@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jul 2010, rd bairva wrote:

> Hi ,
>       My board has a hardware JPEG decoder. I want to write a driver
> for this in Linux kernel, But it seems there that no Framework exists
> in kernel. Can somebody provide me some pointers?

drivers/media/video, maybe v4l2-mem2mem kind of thing.

Regards
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
