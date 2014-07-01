From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 01 Jul 2014 19:18:41 +0400
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <20140701104254.GD3427@piout.net>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140627032506.GA18039@shlinux1.ap.freescale.net>
 <20140630133313.GA11880@kwain>
 <20140701002112.GA26146@shlinux1.ap.freescale.net>
 <53B27789.3090509@gmail.com>
 <20140701083007.GB26146@shlinux1.ap.freescale.net>
 <20140701104254.GD3427@piout.net>
Message-ID: <53B2D151.60404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/01/2014 02:42 PM, Alexandre Belloni wrote:

>>>>> Well, there is nothing specific about the Berlin CI. Some subsystems
>>>>> use the 'generic' keyword in these cases. Do you see a particular reason
>>>>> I should use some Berlin related compatible here?

>>>> Not must, one suggestion is: can you change the compatible string
>>>> to "chipidea-usb-generic"?

>>> I don't know about ChipIdea/ARC/DW's product portfolio but I guess
>>> the compatible should also carry '2.0' or 'usb2' in it. Or we just
>>> use some version number like 'chipidea,ci13000' or 'chipidea,ci13xxx'.

>> The recommended format for compatible string is: "manufacturer,model",
>> I agree with "chipidea,ci13xxx", thanks.

> I think we should probably avoid using wildcards in the compatible
> string.

    I'm sure wildcards shouldn't be allowed there. :-)

WBR, Sergei
