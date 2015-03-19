From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 19 Mar 2015 18:13:56 +0530
Subject: [PATCH 3/3] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <20150319095738.GY3318@x1>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
 <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
 <CAJe_Zhc1uLf_grsbzOs3ahJHJXXZ+BF__702mEPPL=SWPU5nzw@mail.gmail.com>
 <20150318131226.GM3318@x1>
 <CABb+yY2HwZn3VSvZ4iVfWE8GrsLDA6Tx_V2HZiOBvJb9UHY2Mg@mail.gmail.com>
 <20150318152658.GO3318@x1>
 <CABb+yY0tMwYTFDvF2Gce4h5xhKOboLS=32yK42-eoksZ8SAbZA@mail.gmail.com>
 <20150319095738.GY3318@x1>
Message-ID: <CABb+yY1Z3qPyKPRNqhG6q9wxzECziq6HMQsht0SxCzPB5KGjog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 3:27 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 19 Mar 2015, Jassi Brar wrote:
>
>> And also no header that's included by exactly one file.
>
> So you also want me to drag in all of the controller structs into the
> driver?
>
Yes, please. Why have structures, internal to a code, in a header
file? Lets keep file count low.

thanks.
