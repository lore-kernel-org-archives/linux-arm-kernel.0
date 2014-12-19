From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 19 Dec 2014 11:56:48 -0800
Subject: [PATCH 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
In-Reply-To: <549481C5.7050802@broadcom.com>
References: <549481C5.7050802@broadcom.com>
Message-ID: <3710249.R7buLtFklK@dtor-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 19, 2014 11:51:33 AM Jonathan Richardson wrote:
> Thanks Joe. I'll send out a new patch set with your suggestions/fixes
> shortly.

You can also drop the remove() code since we clear drvdata automatically and 
input device is managed so does not need to be unregistered explicitly.

Thanks.

-- 
Dmitry
