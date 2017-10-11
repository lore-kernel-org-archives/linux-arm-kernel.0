From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 11 Oct 2017 11:41:53 -0700
Subject: next: arm64: LTP sendto01 test causes system crash in ilp32 mode
In-Reply-To: <20171011183522.tm2xxgzbdspjtsax@yury-thinkpad>
References: <20171011183522.tm2xxgzbdspjtsax@yury-thinkpad>
Message-ID: <1507747313.31614.27.camel@edumazet-glaptop3.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-11 at 21:35 +0300, Yury Norov wrote:
> Hi all, 
> 
> It seems like next-20171009 with ilp32 patches crashes on LTP sendto01 test
> in sys_sendto() path, like this:

Thanks for the report.
Probably caused by one of my recent patches, so I am taking a look.
