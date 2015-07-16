From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 16 Jul 2015 17:17:29 -0500
Subject: [PATCH] ARM: VDSO: fix regression with toolchains lacking ld.bfd
 executable
In-Reply-To: <CACqcpZBnU+17Ob85hYhikQUdNxtNiUs47PGQXfZDQyXYrTgnyg@mail.gmail.com>
References: <1436934852-27547-1-git-send-email-nathan_lynch@mentor.com>
 <CACqcpZBnU+17Ob85hYhikQUdNxtNiUs47PGQXfZDQyXYrTgnyg@mail.gmail.com>
Message-ID: <55A82D79.3000106@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2015 03:34 PM, Rapha?l Poggi wrote:
> Hi Nathan,
> 
> I just tested it right now and it works, you can add my:
> 
> Tested-by: Rapha?l Poggi <poggi.raph@gmail.com>

Thanks.  Are you also using a CodeBench toolchain, or something else?
