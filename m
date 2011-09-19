From: compnerd@compnerd.org (Saleem Abdulrasool)
Date: Sun, 18 Sep 2011 18:45:17 -0700
Subject: No subject
Message-ID: <1316396718-31886-1-git-send-email-compnerd@compnerd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi.

The attached patch adds polled io methods for the mxcuart.  I needed them in
order to use kgdb during the early boot.  The changes have been sitting in (my
and) Genesi's tree for quite some time now.  I believe that the changes are
generally useful and would like you to consider merging them in the "upstream"
repository.

Thanks.

-- 
Saleem Abdulrasool
compnerd (at) compnerd (dot) org
