From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 09:31:53 +0100
Subject: [PATCH 00/15] musb: Add support for the Allwinner sunxi musb
 controller
In-Reply-To: <CAGb2v67GkL9Mdr98Chf6MhMff7CO8OGgfF2kaB3Xcnz=SkMG3w@mail.gmail.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <2227491.z0aBeXi5ZG@wuerfel>
 <CAGb2v67GkL9Mdr98Chf6MhMff7CO8OGgfF2kaB3Xcnz=SkMG3w@mail.gmail.com>
Message-ID: <7198432.YfztEdzB1p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 09:46:24 Chen-Yu Tsai wrote:
> I believe you are talking about "mmio-sram"?

Yes.
 
> The syscon here represents a switch, to toggle whether a block of SRAM is
> mapped into the CPU memory space, or to a specific devices private address
> space. It is not the actual SRAM.
> 
> The SRAM DT binding is orthogonal to this, if not irrelevant when the block
> is mapped privately, as it is no longer visible from the DT's PoV.

Ok, got it. I missed this part when reading the introduction. syscon seems
fine to me then.

	Arnd
