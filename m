From: shussai5@ncsu.edu (Syed Rafiul Hussain)
Date: Tue, 10 Jul 2012 00:13:14 -0400
Subject: TLB flushing
Message-ID: <CANoXcjaoXsYGBwtYAHdxtQTDB=0tAZOcJH4_VRkrPOmYXVAdKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've modified a page in kernel space as non-writable and did tlb flushing.
However, even after making the page non-writable and tlb flushing, I am
still able to write on that page. Has anyone faced similar kind of problem?
Is it a problem of tlb flushing? I would really appreciate if someone could
help me in this regard.


Thanks.

Syed Rafiul Hussain
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/8ea704e2/attachment-0001.html>
