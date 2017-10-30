From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 30 Oct 2017 20:32:15 +0100
Subject: pinctrl: sirf: Use common error handling code in
 sirfsoc_dt_node_to_map()
In-Reply-To: <CAMuHMdXSVXZNW7a-xf_zyCW-j_KVQbRBdrt8q-SNjGChuDU-bw@mail.gmail.com>
References: <80911d4b-d819-335c-106e-70d7672e645b@users.sourceforge.net>
 <CAMuHMdXSVXZNW7a-xf_zyCW-j_KVQbRBdrt8q-SNjGChuDU-bw@mail.gmail.com>
Message-ID: <72b04f56-be81-5a7d-3a43-abac41dd05ba@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Add a jump target so that a bit of exception handling can be better reused
>> at the end of this function.
>>
>> This issue was detected by using the Coccinelle software.
> 
> Does Coccinelle have a threshold for how much cleanup can be shared?

Are you looking for a limitation of such source code search patterns?

Regards,
Markus
