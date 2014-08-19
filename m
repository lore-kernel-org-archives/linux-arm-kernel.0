From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Aug 2014 21:29:20 +0100
Subject: [PATCH v1] Arm64: Remove unnecessary keyword 'extern' from
 proc-fns.h
In-Reply-To: <1408477371.22761.145.camel@smoke>
References: <1408438726-2413-1-git-send-email-achandran@mvista.com>
 <1408477371.22761.145.camel@smoke>
Message-ID: <20140819202920.GA20112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 08:42:51PM +0100, Geoff Levand wrote:
> On Tue, 2014-08-19 at 14:28 +0530, Arun Chandran wrote:
> > As the functions have external linkage by default, the extern
> > keyword is irrelevant here.
> 
> extern is used to say that the storage of a variable is done
> somewhere else.  It marks a statement as a declaration when
> there is ambiguity about if the statement is a definition or
> declaration.  Since function prototypes are not definitions,
> extern doesn't have any effect on them.  It is not really
> related to linkage or scope.

Regardless, this patch doesn't apply.

Will
