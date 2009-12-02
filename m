From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Wed, 02 Dec 2009 09:43:03 +0100
Subject: USB support on i.MX27
In-Reply-To: <37367b3a0912010651s2f7b6d0csc8fc73e088195697@mail.gmail.com>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>	<20091127101654.GP14091@buzzloop.caiaq.de>	<37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>	<37367b3a0911301157k2a15cb80q5624cbd3f96063b8@mail.gmail.com>	<37367b3a0912010616r26ff385bqe6b85db1c510822f@mail.gmail.com>	<20091201142609.GP14091@buzzloop.caiaq.de>
	<37367b3a0912010651s2f7b6d0csc8fc73e088195697@mail.gmail.com>
Message-ID: <4B162897.1080402@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel and Alan,

Alan Carvalho de Assis wrote:
> Hi Daniel,
> 
> On 12/1/09, Daniel Mack <daniel@caiaq.de> wrote:
>> Hmm, I don't follow. You added some debug output and it started working,
>> is that what you say? Do we possibly need memory barriers somewhere?
>>
> 
> Basically it, but I will do more tests to isolate the issue.
> 
> In fact there is a board where the issue remain, but using old kernel
> (2.6.22) both work.

I am also investigating this issue. The same happens sometimes with my 
USB host with ULPI-ISP1504, but it never happens with the USB slave with 
the exact same hardware ULPI-ISP1504, that's why I have the feeling that 
it's a purely software issue.

I also had the feeling that it was a timing issue (maybe with a clock 
not ready at the right time) and what I read from Alan comforts me with 
this feeling. But I haven't been able to isolate this either.

Best Regards

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
