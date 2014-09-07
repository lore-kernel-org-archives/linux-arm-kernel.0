From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 07 Sep 2014 08:55:53 +0800
Subject: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
In-Reply-To: <20140906135550.GD2601@sirena.org.uk>
Message-ID: <D031CD59.21619%21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14-9-6 ??9:55, "Mark Brown" <broonie@kernel.org> wrote:

>On Fri, Sep 05, 2014 at 04:14:17PM +0800, Barry Song wrote:
>
>> i have no strong technical reason for this as the benefit is not
>> always technical. you know....the commit log has provided the reason
>> for this patch.
>> the difficulty for me is maintaining the difference between mainline
>> and local codes, but if we have to maintain two copies,  we can.
>
>OK, well I think that's best though it would be better if we were able
>to understand what benefit your customers believe they are seeing here
>and hopefully address it in a better way.  Doing this sort of thing with
>Kconfig options is not great, especially when you start trying to build
>kernels that work with more than one board.

my goal is doubling-check this with customers, if there is no problem,
drop this one as it is not a valid technical solution.

-barry
