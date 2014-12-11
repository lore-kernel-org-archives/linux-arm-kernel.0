From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 11 Dec 2014 10:17:58 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <CAJe_ZhfKFdrV8=oMiH0hJeOmGAmPNbZ7rUXsqN+Ak7PvOnZEmA@mail.gmail.com>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
 <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
 <20141205151843.GV11285@n2100.arm.linux.org.uk>
 <CAJe_ZhfDsfehCXHB6pCuQ6672kXBYFxh687cZT1qaSCOyLy76g@mail.gmail.com>
 <20141208130727.GK16827@intel.com>
 <CAJe_ZhfKFdrV8=oMiH0hJeOmGAmPNbZ7rUXsqN+Ak7PvOnZEmA@mail.gmail.com>
Message-ID: <20141211044758.GH16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 08:48:04PM +0530, Jassi Brar wrote:
> As Russell pointed out, that ain't the case either.
> So we are yet to figure out benefits of having explicit
> issue_pending() after tx_submit().
callback ?

-- 
~Vinod
