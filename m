From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 24 Apr 2018 15:47:12 +0200
Subject: [PATCH] arm64: support __int128 with clang
In-Reply-To: <20180424133527.GB24599@arm.com>
References: <20171223004323.1986-1-Jason@zx2c4.com>
 <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
 <20180424133527.GB24599@arm.com>
Message-ID: <CAHmME9pB-CobQCsm2nNHZq_o8qn2+Fff3cGgshyTaQVXtZpWHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 3:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Sun, Apr 15, 2018 at 06:20:11PM +0200, Jason A. Donenfeld wrote:
>> Would you review/merge this when you have a chance?
>
> No real objection from me, but does the arm64 kernel actually build with
> clang?

I've been told that Android is moving their kernel builds over to
clang entirely.
