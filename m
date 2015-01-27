From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Tue, 27 Jan 2015 23:43:51 +0800
Subject: [PATCH v8 0/2] Add Spreadtrum SoC bindings and serial driver
 support
In-Reply-To: <20150127145518.GA32531@kroah.com>
References: <1422345407-10037-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <2196748.ag4UzqF1Px@wuerfel> <20150127145518.GA32531@kroah.com>
Message-ID: <CAAfSe-sPv+TDrUXYfW8DRJZiXjhVpRr=Wd3td7kHeB5r2LEnjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 10:55 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Jan 27, 2015 at 02:24:02PM +0100, Arnd Bergmann wrote:
>> On Tuesday 27 January 2015 15:56:45 Chunyan Zhang wrote:
>> > This patch-set split the last version, and addressed the review comments from
>> > last version on serial driver code.
>> >
>> > Changes from v7:
>> > * Addressed review comments from Peter:
>> >         - Initialized the stack local with zero in sprd_set_termios()
>> >         - Used dev_get_drvdata() to get sprd_uart_port
>> >
>>
>> Looks good to me, but you still have too many people on 'To', so Greg
>> might be missing that you expect him to merge it.
>>
>> Greg, if there are no further comments, can you take both patches through
>> the tty git?
>
> Will do, thanks.
>
> greg k-h

To Arnd, Greg, Peter, and to all of others

thank you so much for your help.
You all gave us so many important comments and valuable suggestions
these months.

Best regards,
Chunyan
