From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 21 Aug 2018 10:53:18 +0530
Subject: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
Message-ID: <2e997c62-371c-1d9d-97ab-65726f588ab5@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Song,

> However, if I start a.out AFTER enabling the uprobe, there is something wrong:
> 
> root at virt-test:~# ~/a.out
> 11
> semaphore 0       <<< this should be non-zero, as the uprobe is already enabled

Ok. I'm able to reproduce this. Digging deeper.

Ravi
