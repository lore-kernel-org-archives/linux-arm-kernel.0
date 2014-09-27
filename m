From: bhelgaas@google.com (Bjorn Helgaas)
Date: Sat, 27 Sep 2014 14:18:55 -0600
Subject: [PATCH v12 08/12] PCI: OF: Introduce helper function for
 retrieving PCI domain numbers
In-Reply-To: <20140926224752.GB22030@e106497-lin.cambridge.arm.com>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-9-git-send-email-Liviu.Dudau@arm.com>
 <CAL_Jsq+j40Xf208wCf4as3H=cDU=htJ-JWinB0DjpcORjatNXQ@mail.gmail.com>
 <20140926212052.GA6030@borg.dudau.co.uk>
 <CAL_JsqKJ6bfPuOofo4grVm3qW_WOpUzcS1juZvHxZdFyyF_19A@mail.gmail.com>
 <20140926224752.GB22030@e106497-lin.cambridge.arm.com>
Message-ID: <CAErSpo5Q-gZaeV91+UeMjmnUt7jqGndDY6zfZqsDWJUNh+Gm6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Yinghai]

On Fri, Sep 26, 2014 at 4:47 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Fri, Sep 26, 2014 at 10:53:26PM +0100, Rob Herring wrote:

>> I thought Bjorn already applied the series. Who's agreement are you
>> waiting for specifically.
>
> Looks like he only applied about 60% of the series.

I applied it all but Yinghai pointed out a problem with a patch in the
middle, so I dropped that patch and everything after it because I didn't
have time to work out whether the later patches depended on anything
in the one I dropped.

Bjorn
