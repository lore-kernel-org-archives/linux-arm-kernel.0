From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 9 Mar 2017 13:56:49 -0700
Subject: outreachy
In-Reply-To: <443f0143-aec1-2559-a2c2-73b245632948@broadcom.com>
References: <alpine.DEB.2.20.1703092133340.2306@hadrien>
 <443f0143-aec1-2559-a2c2-73b245632948@broadcom.com>
Message-ID: <2da12619-5fcb-9e0f-b6c1-c83cbf491e8d@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2017 01:51 PM, Scott Branden wrote:
> Hi Julia,
>
> On 17-03-09 12:36 PM, Julia Lawall wrote:
>> Hello,
>>
>> I discussed the issue of outreachy patches for bcm with Greg, and we are
>> not convinced that not having the patches CCd to you is such a good idea.
>> While we don't want to spam you with noise, some of the applicants are
>> starting to make more significant changes that it could be useful for you
>> to be aware of.
>>
>> Could we try a compromise where you are not CCd on whitespace patches,
>> but
>> you are CCd on patches that actually modify the code?
 >
> All I'm asking is you work through your outreachy patches internal first
> to get rid of the most basic mistakes and email traffic it is geerating.
>  Once that learning process is through then they can be sent out like
> any other patches to the kernel mailing lists and maintainers.

+1 from me too; I find these patches rather high volume and had to add a 
filter to keep them out of my primary inbox. I don't know what process 
is in place, but I would suggest:

1) Senders send everything to the outreachy list, where they are 
reviewed for basic issues, like learning to use git send-email, learning 
checkpatch, etc. In this case, only send the patch to the outreachy 
mailing list and nowhere else.

2) Once a patch has passed review there, then send the patch to the 
regular kernel mailing list just like any other patch; follow the output 
of get_maintainers.pl.

We have something like (1) inside NVIDIA for new contributors and 
pre-upstreaming IP review. It helps all the newcomers, but without 
requiring anyone involved in (2) to change behaviour.

The process I suggest is very much inline with the typically suggested 
"asking questions" process: (1) read docs yourself (2) ask local 
contacts for help, (3) start asking wider audiences for help.
