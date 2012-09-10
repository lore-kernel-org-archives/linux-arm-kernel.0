From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Sep 2012 11:52:14 -0600
Subject: Another tree for "next"
In-Reply-To: <m31ui9g4ff.fsf@intrepid.localdomain>
References: <m3obli3j7a.fsf@intrepid.localdomain>
 <20120910100144.dcbe2715cde0fea51345a354@canb.auug.org.au>
 <m31ui9g4ff.fsf@intrepid.localdomain>
Message-ID: <504E28CE.6020103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2012 11:42 AM, Krzysztof Halasa wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
>>> could you please add the following to your "next" tree?
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux.git  branch: next
> 
>> Could you be a bit more clear about what will be in that tree, please?
>> Also when you repost this request, please post it a bit more widely among
>> other people/lists who may be interested in this work.  Remember that
>> linux-next is really only for stuff that is ready for Linus to pull into
>> the next merge window (or bug fixes).  Also, would this tree be pulled
>> directly by Linus, or via some other tree?
> 
> My plan is to merge all the stuff I'm (eventually) working on in the
> above tree. For now - mostly IXP4xx (ARM CPU etc.) stuff which goes to
> Linus

ARM-SoC-related pull requests should be sent to the arm-soc tree, who
will then aggregate all the ARM-SoC-related changes and issue pull
requests to Linus.

That is, arm at kernel.org, plus the Linux ARM kernel list CC'd.

The patches would also need to be sent to the Linux ARM kernel list (and
any other relevant lists) before being applied to your tree.

ARM core changes would likely go through Russell King's tree, perhaps
depending on what dependencies they have.
