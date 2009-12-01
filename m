From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Tue, 1 Dec 2009 12:51:48 -0200
Subject: USB support on i.MX27
In-Reply-To: <20091201142609.GP14091@buzzloop.caiaq.de>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>
	<20091127101654.GP14091@buzzloop.caiaq.de>
	<37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>
	<37367b3a0911301157k2a15cb80q5624cbd3f96063b8@mail.gmail.com>
	<37367b3a0912010616r26ff385bqe6b85db1c510822f@mail.gmail.com>
	<20091201142609.GP14091@buzzloop.caiaq.de>
Message-ID: <37367b3a0912010651s2f7b6d0csc8fc73e088195697@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 12/1/09, Daniel Mack <daniel@caiaq.de> wrote:
>
> Hmm, I don't follow. You added some debug output and it started working,
> is that what you say? Do we possibly need memory barriers somewhere?
>

Basically it, but I will do more tests to isolate the issue.

In fact there is a board where the issue remain, but using old kernel
(2.6.22) both work.

> Can you post a patch with your changes, please?
>

Sure, I will do that as soon as I isolate it.

Best Regards,

Alan
