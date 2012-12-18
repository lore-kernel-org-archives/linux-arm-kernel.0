From: greg@kroah.com (Greg KH)
Date: Mon, 17 Dec 2012 18:43:53 -0800
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
Message-ID: <20121218024353.GA17118@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 12:01:35AM -0200, Fabio Estevam wrote:
> Hi,
> 
> Booting a 3.7 kernel on a mx6qsabrelite board via NFS and using an
> asix USB/Ethernet adapter and then I try to transfer a 10MB file from
> the target to the host:

Has this ever worked before on any older kernel?

thanks,

greg k-h
