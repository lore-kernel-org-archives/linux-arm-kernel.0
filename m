From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Apr 2017 13:10:16 +0200
Subject: s3c24xx: Use devm_kcalloc() in s3c24xx_dma_probe()
In-Reply-To: <49f1c0b2-7463-2121-1aed-0998f6635c92@math.uni-bielefeld.de>
References: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
 <9c10b823-f49b-8c73-2bf8-0fd2b0ba0231@users.sourceforge.net>
 <f1257887-ca14-6415-b1ff-d57190a1810f@math.uni-bielefeld.de>
 <02134825-fec7-73d7-2eb6-b510eaaf3b08@users.sourceforge.net>
 <49f1c0b2-7463-2121-1aed-0998f6635c92@math.uni-bielefeld.de>
Message-ID: <b89bfd5c-315a-345f-7239-2d6300cf1f6e@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> WARNING: Prefer devm_kcalloc over devm_kzalloc with multiply
> For example. Also I just noticed some previous comment by Krzysztof that
> pointed that out already.
> 
> My suggestion: One sentence describing that the current situation is.

Why do you find the sentence for the multiplication information inappropriate
(or incomplete) at the moment?


> Another sentence explaining why this is bad/undesirable.

Which details do you miss here?


> In this case, the output of the checkpatch script would come in handy.

Its implementation of the check ?ALLOC_WITH_MULTIPLY? considers only an other
search pattern so far.

* Do you find it worthwhile to add a prefix like ?devm_? to the used
  regular expression?

* Would like to improve any related scripts for the semantic patch language
  (Coccinelle software) a bit more?


> With this, you avoid cramming every information into one long and
> complicated sentence.

Thanks for your feedback about other wording preferences.

Regards,
Markus
