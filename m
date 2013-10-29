From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 29 Oct 2013 13:50:22 +0800
Subject: question about  Make CONFIG_STRICT_MEMORY_RWX even stricter   patch 
Message-ID: <35FD53F367049845BC99AC72306C23D101592A7054F5@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  ,

We will cherry-pick this patch :
http://cgit.sonyericsson.net/cgit.cgi/kernel/msm.git/commit/?id=2504e77ddedfa34dbd64e757a14e5b21a613c000

for security reason ,

but I have a question about this patch ,
this patch will make .text  section  permission become RX but not writable ,
so  some features like  kprobe / jump_label  may can't work correct,
these  features will change code during runtime ,
so it will result in page fault  if it write .text section .


Thanks 



Yalin.Wang
Software Engineer 
OS Kernel&Graphics
?
Sony Mobile Communications
Tel: +86 10 5966 9819
Phone: 18610323092
Address: No.16 Guangshun South Street, Chaoyang, Beijing, P.R.C.

sonymobile.com
??
?
