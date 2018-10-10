From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue, 9 Oct 2018 17:00:03 -0700
Subject: [PATCH i2c-next v7 3/5] dt-bindings: i2c: aspeed: Add
 'bus-timeout-ms' property as an optional property
In-Reply-To: <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g44WcAE5oJCmRQKsRmbrfYPx55kdaT6xW1hzCoYAR5YQNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 2:45 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds 'bus-timeout-ms' property as an optional property
> which can be used for setting the bus timeout value of an adapter.
> With this patch, the bus timeout value can be set through this
> property at the probing time of this module. Still the bus timeout
> value can be set by an I2C_TIMEOUT ioctl on cdev at runtime too.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for putting all the work in to do it this way!
