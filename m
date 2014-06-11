From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 11 Jun 2014 15:18:02 -0700
Subject: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
In-Reply-To: <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
References: <cover.1402517933.git.luto@amacapital.net>
 <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
 <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
 <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
Message-ID: <5398D59A.3030900@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
> 
> 13ns is with the simplest nonempty filter.  I hope that empty filters
> don't work.
> 

Why wouldn't they?

	-hpa
