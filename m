From: davem@davemloft.net (David Miller)
Date: Mon, 12 Jun 2017 18:47:15 -0400 (EDT)
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <20170612224545.GA25584@gmail.com>
References: <593E6B0F.8070901@iogearbox.net>
 <CAHgaXd+DW2bggto=2S9hOdMrtPTvhD2QN4rPf2V8iHewQpg-YA@mail.gmail.com>
 <20170612224545.GA25584@gmail.com>
Message-ID: <20170612.184715.1209071551735119885.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Alemayhu <alexander@alemayhu.com>
Date: Tue, 13 Jun 2017 00:45:45 +0200

> On Mon, Jun 12, 2017 at 09:10:07PM +0530, Shubham Bansal wrote:
>> 
>> Nope. It looks like a latest addition to testing. Can you please tell
>> me how to test with it?
>>
> cd tools/testing/selftests/bpf/
> make
> sudo ./test_progs

Also, you might need to do a "make headers_install" at the top level
before doing this.
