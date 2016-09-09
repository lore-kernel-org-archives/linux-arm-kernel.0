From: bd-phuc@jinso.co.jp (Bui Duc Phuc)
Date: Fri, 9 Sep 2016 12:06:13 +0900
Subject: [PATCH 7/8] clocksource: Kconfig: Modify CMT config support 64bit
In-Reply-To: <9b18bc0e-3447-6ab2-3c28-54e54a19dc6f@cogentembedded.com>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
 <1473421394-9745-8-git-send-email-bd-phuc@jinso.co.jp>
 <9b18bc0e-3447-6ab2-3c28-54e54a19dc6f@cogentembedded.com>
Message-ID: <fc2f5eb3-7002-5e96-49d4-09577c0c607e@jinso.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei

  Thanks for your comment.

>> +    bool "Renesas CMT timer driver" if ( ARM64 || COMPILE_TEST )
>
>    Parens not needed and the spaces after/before them even less so.
>
OK
I will update in V2

Thanks & best regards.
Bui Duc Phuc
