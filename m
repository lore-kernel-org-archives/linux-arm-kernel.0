From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Feb 2014 12:02:49 +0000
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
References: <1390908022-10287-1-git-send-email-vijay.kilari@gmail.com>
 <1390908022-10287-2-git-send-email-vijay.kilari@gmail.com>
 <20140129105546.GC26622@mudshark.cambridge.arm.com>
 <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
 <20140217130149.GA5856@arm.com>
 <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
Message-ID: <20140218120249.GD11049@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 11:29:40AM +0000, Vijay Kilari wrote:
> On Mon, Feb 17, 2014 at 6:31 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Mon, Feb 17, 2014 at 12:21:45PM +0000, Vijay Kilari wrote:
> >>    If it is ok, can you please merge these patches
> >
> > I was about to merge them but I wanted to try first. Enabling kgd tests
> > at boot time, I get plenty of failures as below. Have you successfully
> > run the kgdb tests?
> 
>   I re-tested v9 version patches with our internal arm64 simulator and
> I don't see these warnings. Also I tested with 3.13 kernel from linaro with v8
> foundation model and no errors are seen (logs below).

It's good to know. Could you please rebase against 3.14-rc3 and rerun
the tests? If they work, please send me your .config file that you used
with the foundation model.

(and since you rebase on 3.14-rc3, you could repost a v10 with all the
acks in place so that it's easier for me to merge)

Thanks.

-- 
Catalin
