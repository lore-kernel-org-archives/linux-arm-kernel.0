From: stigge@antcom.de (Roland Stigge)
Date: Mon, 22 Oct 2012 11:05:49 +0200
Subject: [PATCH RFC 02/15 v5] gpio: Add sysfs support to block GPIO API
In-Reply-To: <CACRpkdagQhUjdbda55JaY-J33MTNsEMMFJ=1je8V428ZkEMb9A@mail.gmail.com>
References: <1350477107-26512-1-git-send-email-stigge@antcom.de>
 <1350477107-26512-3-git-send-email-stigge@antcom.de>
 <20121017190520.GC25996@kroah.com> <507FD4EB.1080204@antcom.de>
 <CACRpkda35jKs9YVNDAo96=0QzdMi+jkvJAzM=nX+HCK-d5+e9Q@mail.gmail.com>
 <50813EB0.9040102@antcom.de>
 <CACRpkdagQhUjdbda55JaY-J33MTNsEMMFJ=1je8V428ZkEMb9A@mail.gmail.com>
Message-ID: <50850C6D.1050300@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 10:55 AM, Linus Walleij wrote:
> On Fri, Oct 19, 2012 at 1:51 PM, Roland Stigge <stigge@antcom.de> wrote:
>> So what do you think about my just proposed idea of always having the
>> "value" argument present, but only useable when "exported" is "1"? Now
>> only talking about the block gpios, but later maybe also for gpios?
> 
> We should atleast be consistent and do it the same way for
> blocks as individual gpios.

OK, I'll leave it as creating-attribute-on-export.

>> But I would only do this if you and Greg consider it reasonable.
> 
> I'm still afraid of this whole thing and would seek Grant's consent.

Yes, he acked. :-)

Thanks,

Roland
