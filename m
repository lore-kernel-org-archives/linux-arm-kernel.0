From: bjorn@mork.no (=?utf-8?Q?Bj=C3=B8rn_Mork?=)
Date: Mon, 08 Feb 2016 14:49:41 +0100
Subject: [PATCH 5/6] net: thunderx: bgx: Add log message when setting mac
 address
In-Reply-To: <56B8987D.7000901@cogentembedded.com> (Sergei Shtylyov's message
 of "Mon, 8 Feb 2016 16:30:37 +0300")
References: <1454933272-45005-1-git-send-email-sunil.kovvuri@gmail.com>
 <1454933272-45005-6-git-send-email-sunil.kovvuri@gmail.com>
 <56B8987D.7000901@cogentembedded.com>
Message-ID: <87vb5z1fd6.fsf@nemi.mork.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> writes:

>    dev_er(), maybe?

I like that!

It's often hard to know whether to print something or be quiet.
pr_er(), dev_er(), netdev_er() etc would be the perfect solution to that
problem.


Bj?rn
