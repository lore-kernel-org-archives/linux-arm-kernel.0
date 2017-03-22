From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 22 Mar 2017 13:54:40 -0700
Subject: [PATCH v4 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <CAJcbSZGLAXmE_mFZMAZgioWExzm3A4vXBKLGJ7DZNAbJOcH8Zw@mail.gmail.com>
References: <20170322203834.67556-1-thgarnie@google.com>
 <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
 <CAJcbSZGLAXmE_mFZMAZgioWExzm3A4vXBKLGJ7DZNAbJOcH8Zw@mail.gmail.com>
Message-ID: <f0cf8766-4ee9-5386-5454-2301f429464c@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/17 13:49, Thomas Garnier wrote:
> 
> We can default to BUGging. I think my approach was avoiding doing a
> BUG_ON just to avoid breaking people.
> 

Breaking on a potentially-exploitable bug is a feature.

	-hpa
