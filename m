From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 20 Nov 2015 12:08:39 +0000
Subject: Tango4 clkgen block
In-Reply-To: <564EFB18.3050104@sigmadesigns.com> (Marc Gonzalez's message of
 "Fri, 20 Nov 2015 11:51:04 +0100")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C94FD.60607@sigmadesigns.com> <yw1xr3jnfg2s.fsf@unicorn.mansr.com>
 <564CA880.1030502@sigmadesigns.com>
 <yw1xmvubfekf.fsf@unicorn.mansr.com>
 <CAOesGMjCw_DYB3OktnQvthqBAQxqeH6F0bXR-KW_36Y9sDh+fg@mail.gmail.com>
 <yw1xio4zfcpc.fsf@unicorn.mansr.com>
 <564DD44E.4010804@sigmadesigns.com>
 <yw1x4mgif3sn.fsf@unicorn.mansr.com>
 <564EFB18.3050104@sigmadesigns.com>
Message-ID: <yw1xbnaoeuuw.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> M?ns Rullg?rd wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> For example, what is the point of not ignoring sysclk_premux, when the boot
>>> loader has always hard-coded "PLL1 drives sys_clk, PLL2 drives cd_clk".
>> 
>> What if the boot loader changes?  Since we know the structure of the
>> clock tree, it's safer to check how it is actually configured.
>
> In my opinion, this might be the problem.
>
> You think you grok the clkgen block, based on
>
> 1) buggy driver code written by Sigma
> 2) obsolete and/or incorrect documentation (it mentions tango1 for crying out loud)
> 3) limited testing on 8642 and 8759

I also have documentation for SMP8654 that I found on some Chinese web
site.  I've played around with most of the controls, and things behave
as expected.  Where the Sigma code and documentation are ambiguous or
disagree, I have tested what the hardware actually does for various
values.

-- 
M?ns Rullg?rd
mans at mansr.com
