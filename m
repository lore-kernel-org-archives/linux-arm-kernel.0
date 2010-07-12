From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Jul 2010 18:58:41 +0900
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <AANLkTin1M4CnLb1sj9mZiePjF4SvgRXySyJmT4eWpJlj@mail.gmail.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTin1M4CnLb1sj9mZiePjF4SvgRXySyJmT4eWpJlj@mail.gmail.com>
Message-ID: <001601cb21a8$d1cdd120$75697360$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:

> 
> Interesting.
> 
> I got tested with
> #define MAX_PHYSMEM_BITS        31
> #define SECTION_SIZE_BITS       27
> 
> # cat /proc/sys/vm/min_free_kbytes
> 1832
> # echo 1828 > /proc/sys/vm/min_free_kbytes
> # cat /proc/sys/vm/min_free_kbytes
> 1828
> # echo 1820 > /proc/sys/vm/min_free_kbytes
> # cat /proc/sys/vm/min_free_kbytes
> 1820
> # echo 1700 > /proc/sys/vm/min_free_kbytes
> # cat /proc/sys/vm/min_free_kbytes
> 1700
> 
> No kernel panic.
> 

Thanks for your test on the board.

But I need your environment for comparing.

Please let me know.
Following is my board environment.
