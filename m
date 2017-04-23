From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Apr 2017 14:36:05 +0200
Subject: s3c24xx: Use devm_kcalloc() in s3c24xx_dma_probe()
In-Reply-To: <bb42bc46-cb12-cd32-ecd9-ae9b991b476b@math.uni-bielefeld.de>
References: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
 <9c10b823-f49b-8c73-2bf8-0fd2b0ba0231@users.sourceforge.net>
 <f1257887-ca14-6415-b1ff-d57190a1810f@math.uni-bielefeld.de>
 <02134825-fec7-73d7-2eb6-b510eaaf3b08@users.sourceforge.net>
 <49f1c0b2-7463-2121-1aed-0998f6635c92@math.uni-bielefeld.de>
 <b89bfd5c-315a-345f-7239-2d6300cf1f6e@users.sourceforge.net>
 <bb42bc46-cb12-cd32-ecd9-ae9b991b476b@math.uni-bielefeld.de>
Message-ID: <947cea53-0373-f756-d73b-030c9b77e2d0@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Its implementation of the check ?ALLOC_WITH_MULTIPLY? considers only an other
>> search pattern so far.
>>
>> * Do you find it worthwhile to add a prefix like ?devm_? to the used
>>   regular expression?
>>
>> * Would like to improve any related scripts for the semantic patch language
>>   (Coccinelle software) a bit more?
> I don't understand why you're asking this.

Software developers and code reviewers have got different opinions
about such checks and their relevance.


> I'm talking about the _output_ of checkpatch,

This information is clear at first glance.


> not about the script itself.

But it will not provide the warning you might be looking for
while you seem to find my source code analysis approach and
notifications improvable.
I assume that you might be interested in corresponding extensions
for the involved search patterns.


> But undoubtedly your patch is motivated by the output of said tool.

This tool implemented some checks.


> Hence you should mention that.

Additional tools take also care for similar software development concerns,
don't they?

Can it be appropriate to omit the reference to only one Perl script
for related use cases?

Regards,
Markus
