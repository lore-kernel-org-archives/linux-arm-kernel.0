From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Sep 2009 08:40:24 +0800
Subject: [patch for 2.6.31] zaurus c3000 aka spitz: fix resume
In-Reply-To: <1252507740.14793.115.camel@desktop>
References: <20090909075024.GA1400@ucw.cz> <1252507740.14793.115.camel@desktop>
Message-ID: <f17812d70909091740m3ef98e44t18dffc6a2c7c1126@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 9, 2009 at 10:49 PM, Daniel Walker <dwalker@fifo99.com> wrote:
> On Wed, 2009-09-09 at 09:50 +0200, Pavel Machek wrote:
>> Hi, Linus!
>>
>> Spitz resume was broken for year or likely two, and it would be very
>> nice to fix it for 2.6.31 release. One liner is below, and it really
>> can not harm. It already is in Eric's fix queue, so pulling that for
>> .31 should work, too.
>>
>> Do you think you could take it?
>
> One checkpatch error here..
>
> ERROR: trailing whitespace
> #77: FILE: arch/arm/mach-pxa/sharpsl_pm.c:681:
> +^Iif ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) || $
>
> total: 1 errors, 0 warnings, 10 lines checked
>

This has been fixed in the version I sent to Russell.
