From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 4 Jun 2015 19:15:47 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <CAOMqctS6KNrTATB6MYCZLBnZUQmX=e0qQvGf78YtLaF8pkibhQ@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
 <CAMuHMdVT2M7pPHDDHmoNF_zVXhz1PUm5PiYxDKcAjSAcfSDiZg@mail.gmail.com>
 <CAOMqctS6KNrTATB6MYCZLBnZUQmX=e0qQvGf78YtLaF8pkibhQ@mail.gmail.com>
Message-ID: <20150604171547.GA1530@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 10:31:45AM +0200, Michal Suchanek wrote:
> You might want to try to run the bus at 60MHz or 80MHz and then the
> values would probably again be different.
> 
> The first two values are set in DT so the logical place for setting
> the third is also in DT.
> 
> Otherwise you would need some in-kernel table of these settings.

Or a formula.

Thanks,
Richard
