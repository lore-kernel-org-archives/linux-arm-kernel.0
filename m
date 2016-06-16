From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 16 Jun 2016 03:22:36 +0200
Subject: [PATCH] PM / Hibernate: Don't let kasan instrument snapshot.c
In-Reply-To: <57612D0E.5050209@arm.com>
References: <1464870032-12289-1-git-send-email-james.morse@arm.com>
 <7230305.BYjCFel4WC@vostro.rjw.lan> <57612D0E.5050209@arm.com>
Message-ID: <10410002.s5W5iLN5MG@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 15, 2016 11:25:18 AM James Morse wrote:
> Hi Rafael,
> 
> On 15/06/16 00:26, Rafael J. Wysocki wrote:
> > Does the arch code need to be annotated in a similar way too?
> 
> Only if you do the restore copying from C, both 32bit and 64bit x86 do this copy
> in assembly code, which doesn't get instrumented.

OK, that's what I wanted to know.

Thanks!
