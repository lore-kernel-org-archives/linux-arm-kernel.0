From: paul.s.schilling@gmail.com (Paul Schilling)
Date: Wed, 9 Nov 2011 16:12:44 -0600
Subject: s3c2440 / s3c2416 broken
Message-ID: <CAC=G6syKMJk+L+-_k+T37qHKzfpNz_TrYi-HTaufczLxJKEtkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Latest kernel 3.2.0-rc1 appears to break the following processors
s3c2440 and s3c2416

both appear to stall when init is executed on NFS.  Also I  lost HSMMC on
the s3c2416.

Thanks,
Paul
