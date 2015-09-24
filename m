From: geoff@infradead.org (Geoff Levand)
Date: Thu, 24 Sep 2015 12:04:24 -0700
Subject: [PATCH 2/6] arm64: Convert hcalls to use HVC immediate value
In-Reply-To: <CAOZdJXUNhGk59vEnAhXBUun2ieiuUfYH=GKmeB4-wK=azv5HBw@mail.gmail.com>
References: <cover.1426793116.git.geoff@infradead.org>
 <f1d72f4782ef5185626a012872f9ebefe057c7e8.1426793116.git.geoff@infradead.org>
 <CAOZdJXUNhGk59vEnAhXBUun2ieiuUfYH=GKmeB4-wK=azv5HBw@mail.gmail.com>
Message-ID: <1443121464.3637.3.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-23 at 14:21 -0500, Timur Tabi wrote:
> What is the status of this patch?  I see it's not in 4.2.  I ask
> because this patch might be breaking our 4.2-based kernel, and I'm
> just wondering if it's still applicable.

I have it in my linux-kexec repo, which currently based on 4.3-rc2.  I
plan to submit it again in the next week or so after testing.

-Geoff
