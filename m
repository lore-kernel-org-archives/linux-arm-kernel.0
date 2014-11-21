From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Nov 2014 11:55:29 -0200
Subject: [PATCH RFC 3/3] ARM: dts: enable power subsystem for i.MX28
In-Reply-To: <1167895673.64469.1416524223868.JavaMail.open-xchange@oxbaltgw04.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-4-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5AWOs8ODsru+ySsLb=R4ezDL19nK_z0zAXdbrDfPT8KhA@mail.gmail.com>
 <1167895673.64469.1416524223868.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Message-ID: <CAOMZO5ALfkFzA7arhx7+gkS8R_eCjM3=2HnaVn2sAhniEL_1ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 8:57 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

>> Or ''fsl,mxs-power' could be used for both?
>
> I think that would be a bad idea. I can't believe that all PMU register of
> i.MX23 and i.MX28 are identical. So in the future we will have to distinguish
> between them. It's better to do it now like most of the mxs driver does.


Ok, sounds good then.
