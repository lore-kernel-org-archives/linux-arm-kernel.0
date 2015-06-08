From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Jun 2015 10:33:09 +0200 (CEST)
Subject: [PATCH v2] ARM: pxa: ssp: remove unnessary free for devm_xxx
In-Reply-To: <20150608082321.GB26627@firo>
References: <1433750803-26439-1-git-send-email-firogm@gmail.com>
 <alpine.DEB.2.10.1506081008570.2660@hadrien> <20150608081936.GA26627@firo>
 <alpine.DEB.2.10.1506081021170.2660@hadrien> <20150608082321.GB26627@firo>
Message-ID: <alpine.DEB.2.10.1506081032060.2660@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Maybe you can put a comment under the --- explaining the situation.
>
> Sorry, --- stands for what?

In your patch you have a --- after the commit message and before the diff.
If you put some text under the --- and before the diff, the person who
reads the mail will see it, but it will not go into the git log.

julia
