From: robherring2@gmail.com (Rob Herring)
Date: Mon, 18 Feb 2013 15:58:26 -0600
Subject: [Linaro-mm-sig] [PATCH 0/2] Device Tree support for CMA
 (Contiguous Memory Allocator)
In-Reply-To: <CAMcxFTQAOjmzy77eB8nj3JDZ-6mwoMpm8yabtQj04tcLw-giLg@mail.gmail.com>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <20130214213013.GG1906@pengutronix.de> <511D6076.9090503@gmail.com>
 <20130215083304.GK1906@pengutronix.de> <511E6143.609@gmail.com>
 <CAMcxFTQAOjmzy77eB8nj3JDZ-6mwoMpm8yabtQj04tcLw-giLg@mail.gmail.com>
Message-ID: <5122A402.7030807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2013 11:18 PM, Nishanth Peethambaran wrote:
> Limiting the scope of the product to a particular use-case (720p or
> 1080p video playback) will be part of firmware mostly OTP-ed in the
> SoC. Firmware author could decide the amount of CMA memory needed and
> put this as part of DT.

What kernel developer would want a firmware author deciding how much
memory is needed? It is not a decision that can be made without
knowledge of the OS. While the frame size could be determined easily
enough based on resolution, the number of buffers needed cannot.

Rob
