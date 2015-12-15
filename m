From: jcm@redhat.com (Jon Masters)
Date: Mon, 14 Dec 2015 23:11:02 -0500
Subject: memcpy alignment
Message-ID: <566F92D6.8060103@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks,

What's supposed to happen if the natural alignment of the pointers dst
and src is not the same? We don't seem to handle that case today, and
instead will base our access data type on the source alignment only.

Jon.
