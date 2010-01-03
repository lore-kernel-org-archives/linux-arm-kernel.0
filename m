From: arjan@infradead.org (Arjan van de Ven)
Date: Sun, 3 Jan 2010 15:01:34 -0800
Subject: [PATCH] stack2core: show stack message and convert it to core
	file 	when kernel die
In-Reply-To: <4B411F14.1040302@kernel.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<4B411F14.1040302@kernel.org>
Message-ID: <20100103150134.5bdab023@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 04 Jan 2010 07:49:56 +0900
Tejun Heo <tj@kernel.org> wrote:
> 
> If implementing parsing of oops message in C is too awkward
> (unsurprising at all), maybe implementing a converter in perl or
> python is the easiest way so that it takes the oops message and puts
> out well formatted input for the s2c program?

you mean like scripts/markup_oops.pl ?



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
