From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 3 Jan 2012 16:36:44 -0700
Subject: [PATCH 2/7] amp/remoteproc: add debugfs entries
In-Reply-To: <1319536106-25802-3-git-send-email-ohad@wizery.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-3-git-send-email-ohad@wizery.com>
Message-ID: <20120103233644.GD2492@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 11:48:21AM +0200, Ohad Ben-Cohen wrote:
> Expose several remote processor properties (name, state, trace buffer)
> that are helpful for debugging.
> 
> This part is extracted to a separate patch just to keep the review load
> down.
> 
> Designed with Brian Swetland <swetland@google.com>.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/amp/remoteproc/Makefile             |    1 +
>  drivers/amp/remoteproc/remoteproc_debugfs.c |  182 +++++++++++++++++++++++++++
>  2 files changed, 183 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/amp/remoteproc/remoteproc_debugfs.c
