From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 22 Jun 2018 15:08:25 +0200
Subject: [Dev] [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <CAMuUZTH8wXhoBSKwsCFBRBzAvvBBTUTnkmwKEpq=56=URo7kjQ@mail.gmail.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAK8P3a2KqoX-squhGc8TBuJ==8xxELsuy-H+c1+C7Fu7Z4OjDA@mail.gmail.com>
 <CAKv+Gu-gAkfRsEUOc=iyxi6Twvg9cbvWNqNHRS2HzUDZg8xUhg@mail.gmail.com>
 <CAMuUZTG0q4f2T=+HjEijUCLb7KNXok9RJHOXOKNs2iap5p7m5Q@mail.gmail.com>
 <CAKv+Gu_Dq1uY0wHRyREmCmQdSRSJbNheF1ZsrNhibKOZowvf+g@mail.gmail.com>
 <CAMuUZTHOuzQm3y-yF6cad9y1UgsK+6R2w7vSzz7MkkYCdYd3hA@mail.gmail.com>
 <CAKv+Gu80zzaahJhoMScvZ9dS31QobMa0+JFjaOo-GxD+4XsuWQ@mail.gmail.com>
 <CAMuUZTH8wXhoBSKwsCFBRBzAvvBBTUTnkmwKEpq=56=URo7kjQ@mail.gmail.com>
Message-ID: <616e99d3-b43e-58ca-aa82-eaf41f618682@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.6.2018 17:32, Yang Zhang wrote:
> On 19 June 2018 at 16:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
>> On 19 June 2018 at 17:26, Yang Zhang <yang.zhang@96boards.org> wrote:
>>> Yes.
>>>
>>> https://github.com/96boards/documentation/blob/master/
>> mezzanine/files/mezzanine-design-guidelines.pdf
>>>
>>> Under Configuration data section
>>>
>>
>> OK, fair enough. Do any such mezzanines exist yet? Should we offer
>> more guidance on how exactly this discovery should be implemented?
>>
>>
> I can't be sure, could look into it - I know there were couple of from
> Arrow and ST were supporting this.
> 
> Yes, more details guidance of "How to" is always welcome :-).

Unfortunately this is not saying i2c address and also how to handle
stacked solution.

I have told to Linus what Xilinx is using for FMC connector present on
the most of xilinx development boards.
These on board FMC eeproms contain information in FRU format.
Also there incomplete support fmc support in the kernel in drivers/fmc
which was added by Alessandro Rubini in 2013.

At least these eeprom could reuse FRU data format.

Thanks,
Michal
