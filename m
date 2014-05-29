From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 29 May 2014 08:43:42 -0700
Subject: [Patch v2 4/4] tty: serial: msm: Remove direct access to GSBI
In-Reply-To: <A56B810D-869A-4E4F-BC29-C9B0F6CDCE79@codeaurora.org>
References: <1398357082-5102-1-git-send-email-agross@codeaurora.org>
 <1398357082-5102-5-git-send-email-agross@codeaurora.org>
 <A56B810D-869A-4E4F-BC29-C9B0F6CDCE79@codeaurora.org>
Message-ID: <20140529154342.GA28679@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 10:14:35AM -0500, Kumar Gala wrote:
> 
> On Apr 24, 2014, at 11:31 AM, Andy Gross <agross@codeaurora.org> wrote:
> 
> > This patch removes direct access of the GSBI registers.  GSBI configuration
> > should be done through the GSBI driver directly.
> > 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> > drivers/tty/serial/msm_serial.c |   48 ++-------------------------------------
> > drivers/tty/serial/msm_serial.h |    5 ----
> > 2 files changed, 2 insertions(+), 51 deletions(-)
> 
> Greg,
> 
> Any update on pulling this is for next?

I thought this was going through someone else's tree, sorry.  And, there
seemd to be a second set of patches for this, which I don't have
anywhere :(

If you want me to take all of these, or just this one, Andy, can you
please resend?

thanks,

greg k-h
